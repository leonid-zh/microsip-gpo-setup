# MicroSIP Provisioning Script (PowerShell)

## What this file is
`microsip.ps1` is a small PowerShell script that auto-configures the MicroSIP softphone on Windows. It downloads a user list from a Google Sheets CSV and writes the user's SIP settings into `MicroSIP.ini`.

## How it works (short)
- Downloads a CSV from Google Sheets to `%TEMP%\userlist.csv`
- Finds the row where `Username` matches the current Windows user
- Writes SIP server, username, and password into `C:\Users\<User>\AppData\Roaming\MicroSIP\MicroSIP.ini`
- Deletes the temporary CSV

## Requirements
- Windows + PowerShell
- MicroSIP installed
- A published Google Sheets CSV with required columns (`Username`, `Sip Server`, `Sip ID`, `Sip Pass`)

## CSV format
The script expects a semicolon-delimited CSV with at least these columns:
- `Username`
- `Sip Server`
- `Sip ID`
- `Sip Pass`
The SIP server IP/hostname is taken from the `Sip Server` column (specifically the first row of the CSV).

## Usage
1. Edit the script and replace the Google Sheets URL in `$FilePath` with your own published CSV link.
2. Ensure your CSV has the columns listed above.
3. Deploy the script via Group Policy (GPO) as a user logon script on your terminal server.
4. Start MicroSIP — the account should already be configured.

## Notes
- The script uses the first row to read `Sip Server` for all users.
- If the current Windows user is not found in the CSV, no file is written.
- If the user is found but `Sip ID` is empty, the script writes an empty `username=` value, effectively clearing the number.
- The script disables update checks in MicroSIP (`updatesInterval=never`).
