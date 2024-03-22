First, clone this repository:

<!-- start:code block -->
# downlading file ota_updater_apk.dart to your Flutter project


# import ota-updater-apk.dart to  Flutter project 
import 'package:[Project_name]/ota_updater_apk.dart';

# Copy the example .env file
cp .env.example .env

# Initialize the database
npx prisma generate
npx prisma db push

# Run the app
npm run dev

# Open http://localhost:3000 in your browser
open http://localhost:3000
