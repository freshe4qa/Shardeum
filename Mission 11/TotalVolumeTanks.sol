pragma solidity ^0.8.0;

contract TotalVolumeTanks {
    mapping (address => userWaterTankData) users;

    struct userWaterTankData {
        uint currentBlockTime;
        uint8[] currentTankWalls;
        uint totalTanks;
        uint currentWaterVolume;
        uint totalWaterVolume;
    }

    function createNewMap(address user) public {
        users[user].currentBlockTime = block.timestamp;
        uint unixTime = block.timestamp;
        uint decimalTime = unixTime % 10;
        uint8[] memory wallArray = new uint8[8];

        for (uint i = 0; i < wallArray.length; i++) {
            wallArray[i] = decimalTime % 10;
            decimalTime = decimalTime / 10;
            if (wallArray[i] == 0) {
                wallArray[i] = 1;
            } else if (wallArray[i] == 9) {
                wallArray[i] = 8;
            }
        }
        users[user].currentTankWalls = wallArray;
        users[user].totalTanks++;
    }

    function currentTankTotalWaterVolume(address user) public view returns (uint) {
        uint currentVolume = 12 * users[user].currentTankWalls[0] * 1;
        for (uint i = 1; i < users[user].currentTankWalls.length; i++) {
            currentVolume = currentVolume + 12 * 1 * (users[user].currentTankWalls[i] - users[user].currentTankWalls[i - 1]);
        }
        users[user].currentWaterVolume = currentVolume;
        users[user].totalWaterVolume = users[user].totalWaterVolume + currentVolume;
        return users[user].totalWaterVolume;
    }
}
