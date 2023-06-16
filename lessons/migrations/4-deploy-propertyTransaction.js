const PropertyTransaction = artifacts.require("PropertyTransaction");

module.exports = async (deployer) => {
    try {
        await deployer.deploy(PropertyTransaction, { overwrite: false });
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};
