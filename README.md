# Fermi
Get your foot in the door.

##### Server & Database

To setup Fermi's server and database, follow these steps:

- Pull Fermi's code from our [GitHub repository](https://github.com/elliottbolzan/Fermi) to the machine you plan to use as your server.
- Travel to the `backend/database` folder.
- Create and load Fermi's database using the following command: `dropdb fermi; createdb fermi; psql fermi -af create.sql; psql fermi -af load.sql`.
- Travel to the `backend` folder by executing the command `cd ../`.
- Start Fermi's server by executing `python app.py`. If you are running this code on a virtual machine, ensure port 5000 can accept incoming connections.

##### iOS App

To setup Fermi's iOS app, follow these steps:

- Make note of your server's IP address. You may use the server's internal IP address if you plan on running the application on the same WiFi network as the server; otherwise, use the server's external IP address.
- Open `frontend/Fermi/Fermi.xcworkspace` in Xcode.
- In the `Constants.swift` file, set the `host` variable to `http://{IP Address}:5000/`.
- Build and run the project, either on the simulator or an iOS device.
- Enjoy!