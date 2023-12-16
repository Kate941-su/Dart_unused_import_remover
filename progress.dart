import 'dart:io';

/**
 * @param progressCount : the count number which has done the progress of jobs or tasks.
 * @param tatalCount : The total count of jobs or tasks
 */

const _totalHashCount = 50;

void showProgress({required int progressCount, required int totalCount}) {
  if (totalCount == 0) {
    stdout.write('You must not set 0 to totalCount argument');
    return;
  }
  final progressDisplay = '$progressCount/$totalCount';
  final finishedRate = (_totalHashCount * progressCount) ~/ totalCount;
  final finishedRatePercent = (100 * progressCount) ~/ totalCount;
  final finishedHash = '#' * finishedRate;
  final unfinishedAsterisk = '.' * (_totalHashCount - finishedRate);
  stdout.write(
      '\rProgress 👉 [$finishedHash$unfinishedAsterisk] $progressDisplay ($finishedRatePercent%)');
  stdout.flush();
}
