# README
### Ruby version
ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-darwin17]
Rails 5.2.3

### Get Started
bundle install
npm install
rails s

### Usage

##### Step 1: `Browser A`
    - Go to [](http://localhost:3000)
    - Click on "Sign Up"
    - Create a user
    - Login with that user

##### Step 2: `Browser B`
    - Open a private tab
    - Go to [](http://localhost:3000)
    - Click on "Sign Up"
    - Create another user
    - Login with that user
    - Refresh `Browser A`

##### Step 3: Send Kudos
    - `Browser A`: send a kudos to the user logged into `Browser B`
    - `Browser B`: you should have received a Kudos
    - `Browser B`: send a kudos to the user on `Browser A`
    - `Browser A`: you should have received a Kudos
    - Counts should increment automatically without creating extra XHR requests