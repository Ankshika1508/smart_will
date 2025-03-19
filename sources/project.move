module MyModule::SmartWill {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    /// Struct representing a will.
    struct Will has store, key {
        beneficiary: address,
        amount: u64,
    }

    /// Function to create a new will.
    public fun create_will(owner: &signer, beneficiary: address, amount: u64) {
        let will = Will { beneficiary, amount };
        move_to(owner, will);
    }

    /// Function to execute the will and transfer assets to the beneficiary.
    public fun execute_will(executor: &signer, owner: address) acquires Will {
        let will = borrow_global<Will>(owner);
        let transfer_amount = will.amount;
        coin::transfer<AptosCoin>(executor, will.beneficiary, transfer_amount);
    }
}
