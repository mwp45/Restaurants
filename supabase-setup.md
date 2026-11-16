# Utah Table shared rankings

The site no longer asks visitors to sign in. Rankings are stored in Supabase and are public: anyone who can open the site can view and change choices for Mark Phillips, Craig Youngs, and Bradley Ross.

## Enable public shared rankings

1. Open the Supabase project `tnfnprwaqwckjzimgwlc` and choose **SQL Editor**.
2. Open `supabase-public-choices.sql`, paste its contents into a new query, and choose **Run**.
3. The script creates `shared_restaurant_choices`, grants public browser access through the anon role, and copies any existing rankings from the old authenticated tables. The old tables remain in place as a backup.
4. Reload the published site. It should show the person selector, priority choices, and group report without a sign-in prompt.

The site uses the Supabase project URL and publishable key in `index.html`. The publishable key is intended for browser use. Never add a secret or service-role key to the website.

## Public access note

All visitors can view and change all three people’s rankings. Do not store private information in this table. The database limits person names, restaurant IDs, and priorities to the expected values, and each person can have only one restaurant at each rank.
