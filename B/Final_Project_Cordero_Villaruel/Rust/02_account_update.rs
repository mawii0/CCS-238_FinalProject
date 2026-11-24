// Stores the account owner's name and current balance.
struct Account {
    owner: String,
    balance: i64,
}

fn deposit(account: &mut Account, amount: i64) -> Result<(), &'static str> {
    // Reject deposits with negative amounts.
    if amount < 0 {
        return Err("negative deposit");
    }

    // Add the amount to the balance and check for overflow.
    account.balance = account.balance.checked_add(amount).ok_or("overflow")?;
    Ok(())
}

fn main() {
    let mut account = Account {
        owner: String::from("Ada"),
        balance: 100,
    };

    // Try depositing a positive amount and a negative amount.
    let first = deposit(&mut account, 25).is_ok();
    let second = deposit(&mut account, -7).is_ok();

    // Display the account details and deposit results.
    println!("owner: {}", account.owner);
    println!("balance: {}", account.balance);
    println!("first deposit accepted: {}", if first { "T" } else { "F" });
    println!("negative deposit accepted: {}", if second { "T" } else { "F" });
}