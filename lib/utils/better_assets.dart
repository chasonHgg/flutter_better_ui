import 'dart:async';
import 'dart:io';

class BetterAssets {
  static Future<void> generate({
    String projectPath = '',
    String imagePath = 'assets/images',
    String codePath = 'lib/app_res',
    String codeName = 'app_image',
    String className = 'AppImages',
    bool sortByLength = false,
    bool verbose = true,
    void Function(String message)? logger,
  }) async {
    _log(verbose, logger, 'BetterAssets: generation started.');

    final projectDir = _resolveProjectDirectory(projectPath);
    final imageDir = Directory(_joinPath(projectDir.path, imagePath));
    final outputFile = File(
      _joinPath(projectDir.path, '$codePath/$codeName.dart'),
    );

    _log(verbose, logger, 'BetterAssets: project path: ${projectDir.path}');
    _log(verbose, logger, 'BetterAssets: image path: ${imageDir.path}');
    _log(verbose, logger, 'BetterAssets: output file: ${outputFile.path}');

    if (!await imageDir.exists()) {
      _log(verbose, logger, 'BetterAssets: image directory not found.');
      throw FileSystemException('Image directory not found', imageDir.path);
    }

    final imageFiles = await imageDir
        .list(recursive: true, followLinks: false)
        .where((entity) => entity is File)
        .cast<File>()
        .toList();

    _log(
      verbose,
      logger,
      'BetterAssets: found ${imageFiles.length} image file(s).',
    );

    imageFiles.sort((a, b) {
      final aPath = _relativePath(a.path, imageDir.path);
      final bPath = _relativePath(b.path, imageDir.path);
      if (sortByLength) {
        final lengthCompare = aPath.length.compareTo(bPath.length);
        if (lengthCompare != 0) return lengthCompare;
      }
      return aPath.compareTo(bPath);
    });

    final entries = _buildEntries(imageFiles, imageDir.path, imagePath);
    for (final entry in entries) {
      _log(verbose, logger, 'BetterAssets: ${entry.name} -> ${entry.value}');
    }

    final output = _buildClass(className, imagePath, entries);

    await outputFile.parent.create(recursive: true);
    await outputFile.writeAsString(output);

    _log(
      verbose,
      logger,
      'BetterAssets: generation finished. Generated ${entries.length} asset constant(s) in ${outputFile.path}.',
    );
  }

  static Directory _resolveProjectDirectory(String projectPath) {
    if (projectPath.trim().isNotEmpty) {
      return Directory(projectPath);
    }

    var directory = Directory.current;
    while (true) {
      if (File(_joinPath(directory.path, 'pubspec.yaml')).existsSync()) {
        return directory;
      }

      final parent = directory.parent;
      if (parent.path == directory.path) {
        return Directory.current;
      }
      directory = parent;
    }
  }

  static List<_AssetEntry> _buildEntries(
    List<File> files,
    String imageDirPath,
    String imagePath,
  ) {
    final baseNames = <String, int>{};
    final relativePaths = <File, String>{};

    for (final file in files) {
      final relativePath = _relativePath(file.path, imageDirPath);
      relativePaths[file] = relativePath;

      final baseName = _toCamelCase(_fileNameWithoutExtension(relativePath));
      baseNames[baseName] = (baseNames[baseName] ?? 0) + 1;
    }

    return files.map((file) {
      final relativePath = relativePaths[file]!;
      final baseName = _toCamelCase(_fileNameWithoutExtension(relativePath));
      final name = baseNames[baseName] == 1
          ? baseName
          : _toCamelCase(_pathWithoutExtension(relativePath));

      return _AssetEntry(
        name: name,
        value: '\$basePath/$relativePath',
        directory: relativePath.contains('/')
            ? relativePath.substring(0, relativePath.lastIndexOf('/'))
            : imagePath,
      );
    }).toList();
  }

  static String _buildClass(
    String className,
    String imagePath,
    List<_AssetEntry> entries,
  ) {
    final buffer = StringBuffer()
      ..writeln('class $className {')
      ..writeln("  static const basePath = '$imagePath';");

    String? currentDirectory;
    for (final entry in entries) {
      if (entry.directory != currentDirectory) {
        currentDirectory = entry.directory;
        buffer
          ..writeln()
          ..writeln('  /// directory: $currentDirectory');
      }
      buffer.writeln("  static const ${entry.name} = '${entry.value}';");
    }

    buffer.writeln('}');
    return buffer.toString();
  }

  static String _relativePath(String path, String rootPath) {
    final normalizedPath = path.replaceAll(r'\', '/');
    final normalizedRoot = rootPath.replaceAll(r'\', '/');
    return normalizedPath.substring(normalizedRoot.length + 1);
  }

  static String _fileNameWithoutExtension(String path) {
    final fileName = path.split('/').last;
    return fileName.substring(0, fileName.lastIndexOf('.'));
  }

  static String _pathWithoutExtension(String path) {
    return path.substring(0, path.lastIndexOf('.'));
  }

  static String _toCamelCase(String value) {
    final words = value
        .split(RegExp(r'[^A-Za-z0-9]+'))
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.isEmpty) return 'asset';

    final first = _lowerFirst(words.first);
    final rest = words.skip(1).map(_upperFirst).join();
    final name = '$first$rest';

    return RegExp(r'^[0-9]').hasMatch(name) ? 'asset$name' : name;
  }

  static String _lowerFirst(String value) {
    if (value.isEmpty) return value;
    return value.substring(0, 1).toLowerCase() + value.substring(1);
  }

  static String _upperFirst(String value) {
    if (value.isEmpty) return value;
    return value.substring(0, 1).toUpperCase() + value.substring(1);
  }

  static String _joinPath(String left, String right) {
    if (left.endsWith(Platform.pathSeparator)) return '$left$right';
    return '$left${Platform.pathSeparator}$right';
  }

  static void _log(
    bool verbose,
    void Function(String message)? logger,
    String message,
  ) {
    if (verbose) {
      if (logger == null) {
        Zone.current.print(message);
      } else {
        logger(message);
      }
    }
  }
}

class _AssetEntry {
  const _AssetEntry({
    required this.name,
    required this.value,
    required this.directory,
  });

  final String name;
  final String value;
  final String directory;
}
