var Go = artifacts.require("./Go.sol");

// assert.deepEqual(entry.map(x => x.toString()), arr255, "positions error");
// var SIZE_GOBAN = 10;
// var ENTRY_1 = 2;
// var ENTRY_2 = 4;
// var arr255 = new Array(255).fill('0');
// arr255[0] = '' + ENTRY_1 + '';

contract('Go', accounts => {

  // unit test ////////
  let SIZE_GOBAN = 10
  it("test size Goban", () => Go.deployed().then(contract => contract.sizeGoban.call()
    ).then(fb => assert.equal(fb.toNumber(), SIZE_GOBAN, "Set size goban error")
    ).catch(e => console.log(e))
  )


  // it("set entries", () => {
  //   let SIZE_GOBAN = 10
  //   const POSITION_1 = 4
  //   const POSITION_2 = 2
  //   const SET = true
  //   let positions = new Array(255).fill('0')
  //   positions[0] = '' + POSITION_1 + ''
  //   positions[1] = '' + POSITION_2 + ''
  //   const NB_POSITIONS = 2
  //   const COLOR = true
  //   let liberties = new Array(255).fill('0')
  //   liberties[0] = '0'
  //   const NB_LIBERTIES = 1
  //   return Go.deployed().then((contract) => contract.setSizeGoban(SIZE_GOBAN)
  //     .then((fb) => contract.setEntry(POSITION_1))
  //     .then(result => console.log(result))
  //     .then((fb) => contract.setEntry(POSITION_2))
  //     .then(result => console.log(result))
  //     .then(() => contract.setEntry.call(POSITION_1))
  //     .then((fb) => {
  //       assert.equal(fb, true, "Set entry error")
  //       return contract.getConnection.call(1)
  //     })
  //     .then((fb) => {
  //       console.log(fb)
  //       assert.equal(fb[0], true, "Set connection 1 param error")
  //       assert.deepEqual(fb[1].map(v => v.toString()), positions, "positions error")
  //       assert.equal(fb[2].toString(), NB_POSITIONS, "Set connection 3 param error")
  //       assert.equal(fb[3], COLOR, "Set connection 4 param error")
  //       assert.deepEqual(fb[4].map(v => v.toString()), liberties, "positions error")
  //       assert.equal(fb[5], NB_LIBERTIES, "Set connection 6 param error")
  //       return contract.getIndexConnectionByPosition.call(POSITION)
  //     })
  //     .then((fb) => {
  //       console.log(fb)
  //       assert.equal(fb.toNumber(), 0, "Set index connection error")
  //     })
  //   )
  //   .catch(function(e) {
  //     console.log(e)
  //   })
  // })

  it("GOD", () => {
    let SIZE_GOBAN = 10
    const POSITION_1 = 7
    const POSITION_2 = 2
    const SET = true
    let positions = new Array(255).fill('0')
    positions[0] = '' + POSITION_1
    // positions[1] = '' + POSITION_2 + ''
    const NB_POSITIONS = 1
    const COLOR = true
    let liberties = new Array(255).fill('0')
    liberties[0] = '4'
    const NB_LIBERTIES = 4
    //create Goban 10x10
    return Go.deployed()
      // add entry 7 (1,7)
      .then(contract => contract.setEntry(POSITION_1)
        .then(() => contract.setEntry.call(POSITION_1))
        .then(fb => {
          assert.equal(fb, true, "Set entry error")
          return contract.getConnection.call(0)
        })
        .then(fb => {
          assert.equal(fb[0], true, "Set connection 1 param error")
          assert.deepEqual(fb[1].map(v => v.toString()), positions, "positions error")
          // number entry equal 1
          assert.equal(fb[2].toString(), NB_POSITIONS, "Set connection 3 param error")
          // color white (true)
          assert.equal(fb[3], COLOR, "Set connection 4 param error")
          // liberties 4
          assert.deepEqual(fb[4].map(v => v.toString()), liberties, "positions error")
          // number liberties equal 4
          assert.equal(fb[5], NB_LIBERTIES, "Set connection 6 param error")
          return contract.getIndexConnectionByPosition.call(POSITION_1)
        })
        .then(fb => assert.equal(fb.toNumber(), 0, "Set index connection error")
        )
      ).catch(e => console.log(e))
  })

  // TODO
  // it("test double entries failed", () => {
  //   const SIZE_GOBAN = 10
  //   const POSITION_1 = 1
  //   const POSITION_2 = 2
  //   return Go.deployed().then((contract) => contract.setSizeGoban(SIZE_GOBAN)
  //     .then((fb) => contract.setEntry(POSITION_1))
  //     .then((fb) => contract.setEntry(POSITION_2))
  //   )
  //   .catch(function(e) {
  //     console.log(e)
  //   })
  // })
})
