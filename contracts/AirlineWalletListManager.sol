// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title MyContract
 * @dev ContractDescription
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract AirlineWalletListManager {
    /* --------------------------------- STRUCTS -------------------------------- */
    struct Airline {
        string name;
        address wallet;
        address iExecAddress;
    }
    struct Candidate {
        Airline airline;
        uint[] pro;
        uint[] con;
    }

    /* ------------------------------- STATE VARS ------------------------------- */
    address public owner;
    address public coordinator;
    mapping(uint => Airline) public airlines;
    uint public airlineCount;
    Candidate public candidate;
    bool public isVoting;

    /* -------------------------------- CONSTANTS ------------------------------- */
    Candidate public defaultCandidate =
        Candidate(Airline("No Candidate", address(0), address(0)), new uint[](0), new uint[](0));

    /* ------------------------------- CONSTRUCTOR ------------------------------ */
    constructor(address _coordinator, Airline[] memory _airlines) {
        owner = msg.sender;
        coordinator = _coordinator;
        isVoting = false;
        for (uint i = 0; i < _airlines.length; i++) {
            airlines[i] = _airlines[i];
            airlineCount++;
        }
        candidate = defaultCandidate;
    }

    /* --------------------------------- EVENTS --------------------------------- */
    event AirlineProposed(string name);
    event AirlineAdded(string name);
    event AirlineRejected(string name);

    /* -------------------------------- MODIFIERS ------------------------------- */
    modifier onlyCoordinatorOrAirlines() {
        require(
            msg.sender == coordinator || getAirlineID(msg.sender) >= 0,
            "Only the coordinator or airlines can call this function."
        );
        _;
    }

    modifier onlyAirlines() {
        require(getAirlineID(msg.sender) >= 0, "Only listed airlines can call this function.");
        _;
    }

    modifier onlyVoting() {
        require(isVoting, "There is no voting in progress.");
        _;
    }

    modifier onlyNotVoting() {
        require(!isVoting, "There is already a voting in progress.");
        _;
    }

    /* --------------------------- EXTERNAL FUNCTIONS --------------------------- */
    function propose(
        string memory name,
        address wallet,
        address iExecAddress
    ) public onlyAirlines onlyNotVoting {
        candidate = Candidate(Airline(name, wallet, iExecAddress), new uint[](0), new uint[](0));
        isVoting = true;
        emit AirlineProposed(candidate.airline.name);
    }

    function vote(bool saysYes) public onlyAirlines onlyVoting {
        uint id = getAirlineID(msg.sender);
        if (find(candidate.pro, id)) {
            revert("You already voted pro.");
        }
        if (find(candidate.con, id)) {
            revert("You already voted con.");
        }
        if (saysYes) {
            candidate.pro.push(id);
        } else {
            candidate.con.push(id);
        }

        if (candidate.pro.length > airlineCount / 2) {
            closeVoting(true);
        }
        if (candidate.con.length >= airlineCount / 2) {
            closeVoting(false);
        }
    }

    /* --------------------------- INTERNAL FUNCTIONS --------------------------- */
    function getAirlineID(address wallet) internal view returns (uint) {
        for (uint i = 0; i < airlineCount; i++) {
            if (wallet == airlines[i].wallet) {
                return i;
            } else {
                continue;
            }
        }
        revert("No airline with this address.");
    }

    function addAirline() private {
        airlines[airlineCount] = candidate.airline;
        airlineCount++;
    }

    function closeVoting(bool wasPositive) private {
        if (wasPositive) {
            addAirline();
            emit AirlineAdded(candidate.airline.name);
        } else {
            emit AirlineRejected(candidate.airline.name);
        }
        isVoting = false;
        candidate = defaultCandidate;
    }

    function find(uint[] memory array, uint value) internal pure returns (bool) {
        for (uint i = 0; i < array.length; i++) {
            if (array[i] == value) {
                return true;
            }
        }
        return false;
    }
}
