# Car Décor Business Manager V2.10

## Fixed Cash and Online payment calculation

Fixed a Representative-side bug where the displayed Cash + UPI split was not passed correctly to the sale validation. Example:

Final Amount ₹600
- Cash ₹300
- UPI ₹300
- Total Payment ₹600

Now this submits successfully.

Payment modes:
1. Cash
2. UPI
3. Card
4. Cash and Online

For Cash and Online, Cash Amount + UPI Amount must equal the Final Amount.
