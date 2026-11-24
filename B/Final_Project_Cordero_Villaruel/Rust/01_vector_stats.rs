// Returns the average and highest value in the array.
// Option is used in case the array is empty.
fn summarize(values: &[i32]) -> Option<(f64, i32)> {
    // Check if the array has any values.
    if values.is_empty() {
        return None;
    }

    // Calculate the sum and find the highest value.
    let total: i32 = values.iter().copied().sum();
    let maximum: i32 = *values.iter().max()?;

    // Return the average and maximum value.
    Some((total as f64 / values.len() as f64, maximum))
}

fn main() {
    let values = [4, 7, 2, 9, 3];

    // Get the results from the summarize function.
    let (mean, maximum) = summarize(&values).expect("known nonempty input");

    // Display the results.
    println!("count: {}", values.len());
    println!("mean: {:.2}", mean);
    println!("maximum: {}", maximum);
}