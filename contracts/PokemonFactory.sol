// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Habilidad {
        string nombre;
        string descripcion;
    }

    struct Pokemon {
        uint256 id;
        string name;
        uint256 skills;
        // Habilidad[] habilidades;
    }

    Pokemon[] private pokemons;
    event eventNewPokemon(string message);

    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;
    mapping(uint => Habilidad) public skills;

    function createHability(uint _id, string memory _habilidad, string memory _descripcion) view public {
        Habilidad memory hability;
        hability.nombre = _habilidad;
        hability.descripcion = _descripcion;
        Pokemon memory poke;
        for (uint i = 0; i<pokemons.length; i++){
            if(pokemons[i].id == _id){
                poke = pokemons[i];
            }
        }
    }

    function createPokemon(string memory _name, uint256 _id) public {
        require(bytes(_name).length > 2, "nombre debe tener mas de 2 caracteres");
        require(_id > 0, "id debe ser mayor a 0");
        Habilidad storage skill = skills[_id];
        skill.nombre = '';
        skill.descripcion = '';
        pokemons.push(Pokemon(_id, _name, _id));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon("Pokemon creado con exito");
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }
}
