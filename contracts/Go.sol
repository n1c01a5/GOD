pragma solidity ^0.4.4;

contract Go {
    uint8 public sizeGoban;
    bool colorPlay;
    uint lastCapturePosition;
    uint public log;

    struct Connection {
        bool set;
        uint[255] positions;
        uint8 np_positions;
        bool color;
        uint[255] liberties;
        uint8 nb_liberties;
    }

    Connection[] public connections;

    /// position fait correspondre index de connections
    mapping (uint8 => uint256) public indexConnection;

    function Go (uint8 _sizeGoban) {
      if (_sizeGoban > 16)
        throw;
    }

    function setSizeGoban(uint8 _sizeGoban) returns (uint8){
      sizeGoban = _sizeGoban;
      return sizeGoban;
    }

    function addConnection(uint8 _position, bool _set, uint[255] _positions, uint8 _np_positions, bool _color, uint[255] _liberties, uint8 _nb_liberties) public returns(uint) {
      connections.length++;
      connections[connections.length-1].set = _set;
      connections[connections.length-1].positions = _positions;
      connections[connections.length-1].np_positions = _np_positions;
      connections[connections.length-1].color = _color;
      connections[connections.length-1].liberties = _liberties;
      connections[connections.length-1].nb_liberties = _nb_liberties;
      indexConnection[_position] = connections.length-1;
      return connections.length;
    }

    function getConnection(uint index) public constant returns(bool, uint[255], uint8, bool, uint[255], uint8) {
      return (true, connections[index].positions, connections[index].np_positions, connections[index].color, connections[index].liberties, connections[index].nb_liberties);
    }

    function getIndexConnectionByPosition(uint8 _position) public constant returns(uint256) {
      return indexConnection[_position];
    }

    // mapping pos => indexConnection
    // manytoone connection -< pos
    // pointeur vers Connection




    function setEntry(uint8 _position) returns (bool){

        // si position hors goban
        // verifiy si deja un pion
        // si définit et pas assez de libertés pour poser => throw. Mais verifier si on capture en posant (+1 -1 +sizeGoban -sizeGoban)

// set size for the test
        /*if (_position > sizeGoban)
          throw;*/

        var x = getIndexConnectionByPosition(_position);
        int8 r = -1;
        int8 l = -1;
        int8 u = -1;
        int8 d = -1;


        if(_position > 0 && (_position % sizeGoban) != 0) {
          r = int8(getIndexConnectionByPosition(_position-1));
        }

        if(_position < sizeGoban*sizeGoban && (_position+1 % sizeGoban) != 0) {
          l = int8(getIndexConnectionByPosition(_position+1));
        }

        if(_position-sizeGoban >= 0) {
          r = int8(getIndexConnectionByPosition(_position-sizeGoban));
        }

        if(_position+sizeGoban < sizeGoban*sizeGoban) {
          r = int8(getIndexConnectionByPosition(_position+sizeGoban));
        }

        if(x > 0 && r != -1) {
          uint[255] memory _positions;
          uint[255] memory _liberties;
          _positions[0] = _position;
          _liberties[0] = 4;
          addConnection(_position, true, _positions, 1, true, _liberties, 4);
        }


        // soir si il y a des connections dans l'entourage

        // sinon ajouter des positions



        //_positions.push(_position);

        // if (!indexConnection[_position++].set && _position++ <= sizeGoban*sizeGoban && _position % sizeGoban == 0) {
        //     _liberties.push(_position++);
        // } else if (indexConnection[_position++].set && indexConnection[_position++].set == colorPlay) {
        //     _liberties = indexConnection[_position++].liberties;
        // }

        /*if (!indexConnection[_position--].set && _position-->= 0)
            _liberties.push(_position--);*/

        // if (!indexConnection[_position+sizeGoban].set && _position+sizeGoban<=64)
        //     _liberties.push(_position+sizeGoban);

        // if (_position-sizeGoban >= 0 && _position-sizeGoban>= 0)
        //     _liberties.push(_position-sizeGoban);


        colorPlay = !colorPlay;

        return true;
    }
}
