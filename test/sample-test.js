const { expect } = require("chai");

describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("Calculator");
    const greeter = await Greeter.deploy();
    await greeter.deployed();
    expect(await greeter.nbOperation()).to.equal(0);
  });
});
