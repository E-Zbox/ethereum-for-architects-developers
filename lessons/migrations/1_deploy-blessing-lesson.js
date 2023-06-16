const lessonContract = artifacts.require("Lesson");

module.exports = (deployer) => {
	deployer.deploy(lessonContract);
}
