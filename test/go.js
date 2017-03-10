var Go = artifacts.require("./Go.sol");

// assert.deepEqual(entry.map(x => x.toString()), arr255, "positions error");
// var SIZE_GOBAN = 10;
// var ENTRY_1 = 2;
// var ENTRY_2 = 4;
// var arr255 = new Array(255).fill('0');
// arr255[0] = '' + ENTRY_1 + '';

contract('Go', function(accounts) {

  // unit test ////////
  let SIZE_GOBAN = 10
  it("test size Goban", () => {
    return Go.deployed().then(function(contract) {
      return contract.setSizeGoban.call(SIZE_GOBAN)
    }).then((fb) => {
      assert.equal(fb, SIZE_GOBAN, "Set size goban error")
    }).catch(function(e) {
      console.log(e);
    })
  })

  it("test add Connection", () => {
    let arr255 = new Array(255).fill('0')
    return Go.deployed().then(function(contract) {
      return contract.addConnection.call(1, true, arr255, 2, true, arr255, 1)
    }).then(function(fb) {
      assert.equal(fb.toString(), 1, "Set connection  error")
    }).catch(function(e) {
      console.log(e)
    })
  })

  // functionnal test ////////
  it("test get Connection", () => {
    const POSITION = 1
    const SET = true
    let positions = new Array(255).fill('0')
    positions[0] = '' + POSITION + ''
    positions[1] = '2'
    const NB_POSITIONS = 2
    const COLOR = true
    let liberties = new Array(255).fill('0')
    liberties[0] = '0'
    const NB_LIBERTIES = 1
    return Go.deployed().then((contract) => {
      return contract.addConnection(POSITION, SET, positions, NB_POSITIONS, COLOR, liberties, NB_LIBERTIES)
      .then(() => contract.addConnection.call(POSITION, SET, positions, NB_POSITIONS, COLOR, liberties, NB_LIBERTIES))
      .then((fb) => {
        assert.equal(fb.toNumber(), 2, "Set connection error")
        return contract.getConnection.call(0)
      })
      .then((fb) => {
        assert.equal(fb[0], true, "Set connection 1 param error")
        assert.deepEqual(fb[1].map(v => v.toString()), positions, "positions error")
        assert.equal(fb[2].toNumber(), NB_POSITIONS, "Set connection 3 param error")
        assert.equal(fb[3], COLOR, "Set connection 4 param error")
        assert.deepEqual(fb[4].map(x => x.toString()), liberties, "positions error")
        assert.equal(fb[5].toNumber(), NB_LIBERTIES, "Set connection 6 param error")
        return contract.getIndexConnectionByPosition.call(POSITION)
      })
      .then((fb) => assert.equal(fb, 0, "Set index connection error"))
    }).catch(function(e) {
      console.log(e)
    })
  })

  it("test set entry", () => {
    let SIZE_GOBAN = 10
    const POSITION = 1
    const SET = true
    let positions = new Array(255).fill('0')
    positions[0] = '' + POSITION + ''
    positions[1] = '2'
    const NB_POSITIONS = 2
    const COLOR = true
    let liberties = new Array(255).fill('0')
    liberties[0] = '0'
    const NB_LIBERTIES = 1
    return Go.deployed().then((contract) => contract.setSizeGoban(SIZE_GOBAN)
      .then((fb) => contract.setEntry(POSITION))
      .then(() => contract.setEntry.call(POSITION))
      .then((fb) => {
        assert.equal(fb, true, "Set entry error")
        return contract.getConnection.call(0)
      })
      .then((fb) => {
        assert.equal(fb[0], true, "Set connection 1 param error")
        assert.deepEqual(fb[1].map(v => v.toString()), positions, "positions error")
        assert.equal(fb[2].toString(), NB_POSITIONS, "Set connection 3 param error")
        assert.equal(fb[3], COLOR, "Set connection 4 param error")
        assert.deepEqual(fb[4].map(v => v.toString()), liberties, "positions error")
        assert.equal(fb[5], NB_LIBERTIES, "Set connection 6 param error")
        return contract.getIndexConnectionByPosition.call(POSITION)
      })
      .then((fb) => assert.equal(fb.toNumber(), 0, "Set index connection error"))
    )
    .catch(function(e) {
      console.log(e)
    })
  })
})
