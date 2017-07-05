pragma solidity ^0.4.11;

contract GOD {
    uint8 public sizeGoban = 9;

    struct Connection {
        uint8[9] positions;
        uint color;
        uint8[9] liberties;
        uint nbLiberties;
    }

    Connection[] public connections;

    // store all positions
    mapping(uint => Connection) public positions;

    uint public numConnections;

    function GOD () {
        numConnections++;
        connections.push(Connection([1,2,3,4,5,6,7,8,9], 0, [1,2,3,4,5,6,7,8,9], 9));
        for (uint i=1; i <= sizeGoban; i++) {
            positions[i] = connections[0];
        }
    }

    function addPosition (uint _position, uint _color) returns (uint connectionID, uint8 nbLiberties) {
        require(_position >= 1);
        require(_position <= 9);
        require(positions[_position].color == 0);

        uint8[9] memory _positions;

        // left
        if (
            _position - 1 >= 2
            && positions[_position - 1].color == 0
            && _position != 4
            && _position != 7
        ) {
            nbLiberties++;
        }
        // right
        if (
            _position + 1 <= 9
            && positions[_position + 1].color == 0
            && _position != 3
            && _position != 6
        ) {
            nbLiberties++;
        }
        // top
        if (
            _position >= 4
            && positions[_position - 3].color == 0
        ) {
            nbLiberties++;
        }
        // bottom
        if (
            _position <= 6
            && positions[_position + 3].color == 0
        ) {
            nbLiberties++;
        }
        connectionID = numConnections++;
        connections.push(Connection(_positions, _color, [0,1,0,1,0,0,0,0,0], nbLiberties));
        positions[_position] = connections[connectionID];
    }
}
