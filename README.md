# Car Décor Business Manager V2.2

## User flow

The website opens directly on the **Representative page**. There is no representative login.

### Representative
- Direct access on site load
- Select category
- Enter last 4 digits of car number
- Select décor product when applicable
- Price is automatically applied
- Submit sale
- See today's submitted entries

### Admin
The Representative page contains an **Admin Access** section.
Admin enters credentials there to open the Admin dashboard.

Admin features:
- Today's revenue
- Today's expenses
- Today's profit
- Sales history
- Décor product catalogue and pricing
- Expense entry
- Monthly net sales
- Monthly net profit
- Category breakdown

Demo Admin:
- Username: `admin`
- Password: `admin123`

## Important
This is a browser-local prototype. The demo admin authentication is not production security. The next production step is Supabase Auth + PostgreSQL with Admin-only authentication and direct Representative access.
