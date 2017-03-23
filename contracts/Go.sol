pragma solidity ^0.4.4;

contract Go {
    uint8 public sizeGoban;
    bool colorPlay;
    uint lastCapturePosition;
    uint public log;

    // connection tokens
    struct Connection {
        bool set;
        uint[255] positions;
        uint8 nb_positions;
        bool color;
        uint[255] liberties;
        uint8 nb_liberties;
    }

    // store all connections
    Connection[] public connections;

    // for each position link a connection or empty
    // pointeur vers la connection
    mapping (uint8 => uint256) public indexConnection;

    // constructor
    function Go (uint8 _sizeGoban) {
      if (_sizeGoban > 16)
        throw;
      sizeGoban = _sizeGoban;
    }

    // add a new connextion
    // normal internal function
    function addConnection (uint8 _position, bool _set, uint[255] _positions, bool _color, uint[255] _liberties, uint8 _nb_liberties) internal returns(uint) {
      connections.length++;
      connections[connections.length-1].positions = _positions;
      connections[connections.length-1].set = _set;
      connections[connections.length-1].nb_positions = 1; // TODO chnage this
      connections[connections.length-1].color = _color;
      connections[connections.length-1].liberties = _liberties;
      connections[connections.length-1].nb_liberties = _nb_liberties;
      indexConnection[_position] = connections.length-1;
      return connections.length;
    }

    // set a connextion
    // normal internal function
    function setConnection (uint8 _position, uint256 refConnection) returns(uint) {
      //test
      Connection connection = connections[refConnection];
      connections[refConnection].positions[connection.nb_positions] = _position;
      return refConnection;
    }

    // get a connection
    function getConnection (uint index) public constant returns(bool, uint[255], uint8, bool, uint[255], uint8) {
      return (true, connections[index].positions, connections[index].nb_positions, connections[index].color, connections[index].liberties, connections[index].nb_liberties);
    }

    // get the index of the connection
    // normal internal
    function getIndexConnectionByPosition (uint8 _position) public constant returns(uint256) {
      return indexConnection[_position];
    }

    // mapping pos => indexConnection
    // manytoone connection -< pos
    // pointeur vers Connection



    // set an entry
    // 1 token is free right & left & up & down are free
    function setEntry (uint8 _position) returns (bool) {

      // modifier hors goban
      if (_position > sizeGoban*sizeGoban) {
        throw;
      }

        // si position hors goban
        // verifiy si deja un pion
        // si définit et pas assez de libertés pour poser => throw. Mais verifier si on capture en posant (+1 -1 +sizeGoban -sizeGoban)

// set size for the test
        /*if (_position > sizeGoban)
          throw;*/

        // if there is already a token, throw
        var _indexConnectionByPosition = getIndexConnectionByPosition(_position);

        if (_indexConnectionByPosition > 0) {
          // test
          setConnection(_position, 0);
          return true;
        }

        /*if (indexConnection < 1) {throw;}*/

        int8 r = -1;
        int8 l = -1;
        int8 u = -1;
        int8 d = -1;

        // recuperer les connections s'il y en a
        // if left exists set left position
        if(_position > 0 && (_position % sizeGoban) != 0) {
          l = int8(getIndexConnectionByPosition(_position-1));
        }

        // if right exists set right
        if(_position < sizeGoban*sizeGoban && (_position+1 % sizeGoban) != 0) {
          r = int8(getIndexConnectionByPosition(_position+1));
        }

        // if there is no connection
        if(r != -1 && l != -1) {
          uint[255] memory _positions;
          uint[255] memory _liberties;
          // free position
          _positions[0] = _position;
          _liberties[0] = 4;
          addConnection(_position, true, _positions, true, _liberties, 4);
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
