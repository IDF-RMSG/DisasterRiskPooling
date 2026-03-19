import pandas as pd
from pathlib import Path
from datetime import datetime

SCRIPT_DIR = Path(__file__).parent
INPUT_FILE = SCRIPT_DIR / "public_emdat_download_2026-03-19_forLossSimulator.csv"
OUTPUT_FILE = SCRIPT_DIR / "emdat_country_losses.csv"
METADATA_FILE = SCRIPT_DIR / "emdat_country_losses_last_update.txt"

df = pd.read_csv(INPUT_FILE)

df = df[[
    "DisNo.",
    "Country",
    "Start Year",
    "Disaster Type",
    "Total Affected",
    "Total Damage, Adjusted ('000 US$)",
]].rename(columns={
    "DisNo.":                           "id",
    "Country":                          "Country",
    "Start Year":                       "Year",
    "Disaster Type":                    "Type of event",
    "Total Affected":                   "Sum of Total affected",
    "Total Damage, Adjusted ('000 US$)":"Sum of Total Damage",
})

df["Type of event"] = df["Type of event"].replace("Storm", "Cyclone")

df.to_csv(OUTPUT_FILE, index=False)
last_update_date = datetime.fromtimestamp(OUTPUT_FILE.stat().st_mtime).strftime("%Y-%m-%d")
METADATA_FILE.write_text(last_update_date + "\n", encoding="utf-8")
print(f"Saved {len(df)} rows to {OUTPUT_FILE}")
