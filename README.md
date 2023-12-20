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

When you or your team develop huge project used Flutter or Dart, it sometimes happens that many dart files have `unused import` and output warning messages by `Dart Analysis`.

If you feel it annoying, use `unused_import_remover` package, which helps you such a annoying problem.

## Features

You can choose the directory you want to remove unimport package. And you execute the below command.
That's all!

After you have executed the command, `unused_import_remover` checks all dart files under the direcotry you selected recurcively, finds unused import package -> remove!!

You can get the benefits. Example is written below.

Before you execute `unused_import_remover` command

```
import 'dart:async';
import 'dart:cli';
import 'dart:collection';

class Test1{}
```

After you have executed `unused_import_remover` command

```
/*
Remove unused imported packages automatically !
*/
class Test1{}
```

## Getting started

1. add `unused_import_remover` package in your project

```
dart pub add dev:unused_import_remover
```

## Usage

```dart
dart pub unused_import_remover *DIRECTORY_PATH*
```

## Additional information
