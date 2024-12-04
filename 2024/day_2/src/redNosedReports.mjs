import * as fs from "fs";

export default class RedNosedReports {
  constructor(filePath) {
    this._filePath = filePath;
    this.reports = this.parseRawData();
  }

  parseRawData() {
    const data = fs.readFileSync(this._filePath, "utf-8");
    const dataLines = data.split("\n");
    const reportRows = dataLines.map((line) => line.split(" "));
    const numericReports = reportRows.map((report) => report.map((num) => parseInt(num)));

    return numericReports;
  }

  increasingSafely(reportNums) {
    let prev = reportNums[0];

    for (let i = 1; i < reportNums.length; i++) {
      if (reportNums[i] > prev && Math.abs(reportNums[i] - prev) <= 3) {
        prev = reportNums[i];
      } else {
        return false;
      }
    }

    return true;
  }

  decreasingSafely(reportNums) {
    let prev = reportNums[0];

    for (let i = 1; i < reportNums.length; i++) {
      if (reportNums[i] < prev && Math.abs(prev - reportNums[i]) <= 3) {
        prev = reportNums[i];
      } else {
        return false;
      }
    }

    return true;
  }

  isSafe(reportNums) {
    return this.increasingSafely(reportNums) || this.decreasingSafely(reportNums);
  }

  safeReportsCount() {
    const safeReports = this.reports.filter((reportNums) => this.isSafe(reportNums));
    return safeReports.length;
  }

  // TODO:
  increasingSafelyWithProblemDampener(reportNums) {
    // how to remove one problem
  }

  // TODO:
  decreasingSafelyWithDampener(reportNums) {
    // how to remove one problem
  }

  isSafeWithProblemDampener(reportNums) {
    return (
      this.increasingSafelyWithDampener(reportNums) || this.decreasingSafelyWithDampener(reportNums)
    );
  }

  safeReportsWithProblemDampener() {
    const safeReports = this.reports.filter((reportNums) =>
      this.isSafeWithProblemDampener(reportNums)
    );
    return safeReports.length;
  }
}

class ProblemDampener {
  constructor(reportNums) {
    this.reportNums = reportNums;
  }

  increasingSafely() {
    let notIncreasingSafely = (prev, next) => {

    }

    let removedOneProblem = false;
    for(let i = 1; i < this.reportNums.length; i++) {
      // todo
    }

    return true;
  }

  decreasingSafely() {
    let notDecreasingSafely = (prev, next) => {

    }

    let oneProblemDampened = false;
    for(let i = 1; i < this.reportNums.length; i++) {
      // todo
    }

    return true;
  }
}
