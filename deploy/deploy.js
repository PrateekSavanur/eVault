const { verify } = require("../utils/verify")

module.exports = async ({ deployments, getNamedAccounts }) => {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    const chainId = network.config.chainId

    log("deploying..........")

    arguments = ["Government Identity", "GID"]

    const evaultContract = await deploy("eVault", {
        from: deployer,
        args: arguments,
        log: true,
    })

    log(`Deployed at ${evaultContract.address}`)

    if (chainId != 31337) {
        await verify(evaultContract.address, arguments)
        log("Verified Successfully")
    }
}

module.exports.tags = ["deploy"]
