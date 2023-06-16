const MyFirstToken = artifacts.require("MyFirstToken");

module.exports = async (deployer) => {
    try {
        await deployer.deploy(MyFirstToken, { overwrite: false });
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};
