fn main() {
    let tokens = ["12", "oops", "7", "-3", "25"];
    let mut accepted = 0;
    let mut rejected = 0;
    let mut total: i32 = 0;

    // Go through each string and try to convert it into an integer.
    for token in tokens {
        match token.parse::<i32>() {
            Ok(value) => {
                // Count valid inputs and add their values to the total.
                accepted += 1;
                total += value;
            }
            // Count inputs that cannot be converted into integers.
            Err(_) => rejected += 1,
        }
    }

    // Display the number of accepted and rejected inputs and their total.
    println!("accepted: {}", accepted);
    println!("rejected: {}", rejected);
    println!("total: {}", total);
}