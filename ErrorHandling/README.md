Smart Contract that implements the require(), assert() and revert() statements.

assert() => which checks if the bank cap is limited to 20 WEI, while depositing and withdrawing.
```
        // Assert
        assert(limitBank <= 20 && limitBank >= 0);
```
require() => which checks if the balance of a given account is greater than the requested WEI, while withdrawing. 

```
        // Require
        require(balances[_account] > _number, "You're broke!");
```
revert() => which checks if the balance of a given account is greater than the WEI that should be transferred. 
```
        // Revert
        if(balances[_from] < _number){
        revert("You do not have enough funds for this transaction");
        }
```