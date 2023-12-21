<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Unused Import Remover (Dart)

## Abstraction

When you or your team develop a huge project using Flutter or Dart, it sometimes happens that many Dart files have `unused import` and output warning messages by `Dart Analysis`.

If you feel it is annoying, use the `unused_import_remover` package, which helps you with such an annoying problem.

## Features

You can choose the directory in which you want to remove the unimportant package. you execute the below command.

```
dart pub run unused_import_remover
```

That's all!

After you have executed the command, `unused_import_remover` checks all dart files under the directory you selected recursively, finds unused import package -> remove!!

You can get the benefits. An example is written below.

**Before**

```
import 'dart:async';
import 'dart:cli';
import 'dart:collection';

class Test1{}
```

**After**

```

class Test1{}
```

## Installation

add `unused_import_remover` package in your project

```
dart pub add dev:unused_import_remover
```

## Usage

```dart
dart pub run unused_import_remover *DIRECTORY_PATH*
```

## Additional information

Ensure that you have to set _DRECTORY_PATH_, not _FILE_PATH_

Correct

```
dart pub run unused_import_remover ./
```

```
dart pub run unused_import_remover ./*DIRECTORY_NAME*/
```

You don't have to pub last `/`.

```
dart pub run unused_import_remover ./*DIRECTORY_NAME*
```

Incorrect

```
dart pub run unused_import_remover ./*.dart
```

```
dart pub run unused_import_remover ./*.dart
```

```
dart pub run unused_import_remover ./specific_file.dart
```
