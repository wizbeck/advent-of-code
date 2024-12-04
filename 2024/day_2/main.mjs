import { dirname, join as pathjoin } from "path";
import { fileURLToPath } from "url";
import RedNosedReports from "./src/redNosedReports.mjs";

function pathToFile(filename) {
  const $dirname = dirname(import.meta.url);
  const fullPath = pathjoin($dirname, filename);
  const fileURL = fileURLToPath(fullPath);
  return fileURL;
}

function main() {
  // solution one test
  const solutionOneTest = new RedNosedReports(pathToFile("test.txt"));
  solutionOneTest.parseRawData();
  console.log("Test Solution: ", solutionOneTest.safeReportsCount());

  // solution one actual
  const solutionOne = new RedNosedReports(pathToFile("input.txt"));
  solutionOne.parseRawData();
  console.log("Solution One: ", solutionOne.safeReportsCount());

  // TODO: make these work
  // solution two test
  const solutionTwoTest = new RedNosedReports("test.txt");
  solutionTwoTest.parseRawData();
  console.log(solutionTwoTest.safeReportsWithProblemDampenerCount());

  // solution two actual
  const solutionTwo = new RedNosedReports("input.text");
  solutionTwo.parseRowData();
  console.log("Solution Two (w/ProblemDampener): ", solutionTwo.safeReportsWithProblemDampenerCount());
}

main();
