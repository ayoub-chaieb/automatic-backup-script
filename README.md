# 🔐 Encrypted Password File Backup Script – `backup.sh`

## 🧾 Project Summary

I successfully delivered a robust, automated solution to back up sensitive encrypted password files modified in the last 24 hours. The deliverable was a fully functional Bash script (`backup.sh`) scheduled via `cron`, ensuring daily, secure, and timestamped archiving of updated credentials.

---

## 🚀 Key Achievements

✅ Developed a **modular, well-documented Bash script** for secure backups
✅ Implemented **timestamp-based logic** to detect file changes within the last 24 hours
✅ Used array handling to dynamically collect files eligible for backup
✅ Created **compressed tarball backups** with precise naming convention
✅ Deployed the script to `/usr/local/bin/` and verified execution permissions
✅ Validated behavior with sample sensitive documents and manual triggering
✅ Automated execution using **cron**, scheduled every 24 hours
✅ Confirmed backup file creation and proper destination placement

---

## 📦 Features

* 🔍 **Change Detection**: Backs up only the files modified in the past 24 hours
* 🕰️ **Timestamped Backups**: Ensures traceability with naming like `backup-<timestamp>.tar.gz`
* 🔐 **Secure Handling**: Focused on encrypted password file scenarios
* 🧰 **Portable CLI Tool**: Script installed under `/usr/local/bin` for universal access
* 📆 **Cron Integration**: Seamless daily backups without manual intervention

---

## 🛠 Script Usage

```bash
./backup.sh <targetDirectory> <destinationDirectory>
```

📂 Example:

```bash
./backup.sh important-documents /home/project
```

The script will:

* Scan `important-documents/` for updated files
* Archive and compress them
* Output `backup-<timestamp>.tar.gz` to `/home/project`

---

## 📂 Example Backup Output

```bash
backup-1720895642.tar.gz
```

Created inside the destination directory, containing only the relevant files updated in the last 24 hours.

---

## 📅 Cron Job Configuration

To automate the script execution every 24 hours, a cron job was created with:

```cron
0 0 * * * /usr/local/bin/backup.sh /path/to/source /path/to/destination
```

During testing, the cron service was manually started in the environment using:

```bash
sudo service cron start
```

…and stopped afterward with:

```bash
sudo service cron stop
```

---

## 🧪 Testing Procedure

1. Deployed `important-documents.zip` test package
2. Unzipped and used `touch` to simulate recent modification timestamps
3. Executed `backup.sh` and verified archive generation
4. Moved script to `/usr/local/bin/` and set `+x` permission
5. Scheduled cronjob and validated repeated backup creation

---

## 📁 Final Directory Structure

```bash
.
├── backup.sh
├── important-documents/
├── backup-*.tar.gz
└── /usr/local/bin/backup.sh  # Globally executable
```
