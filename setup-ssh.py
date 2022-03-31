import os
import sys
import subprocess

if os.geteuid() != 0:
    subprocess.call(["sudo", "python3.10", *sys.argv])
    sys.exit()


options = [
    ("UsePAM yes", "UsePAM no"),
    ("ChallengeResponseAuthentication yes", "ChallengeResponseAuthentication no"),
    ("PasswordAuthentication yes", "PasswordAuthentication no")
]

file_path = "/etc/ssh/sshd_config"
with open(file_path, "r") as config_file:
    lines = config_file.readlines()

new_lines = []
set_options = set([])
replaced_options = []

for line in lines:
    was_replaced = False
    for (old, new) in options:
        lower_line = line.lower()
        lower_old = old.lower()

        if lower_line.find(lower_old) >= 0:
            suffix = ""
            if lower_line.endswith("\n"):
                suffix = "\n"

            new_lines.append(new + suffix)
            set_options.add(new.lower())
            replaced_options.append((old, new))
            was_replaced = True
            continue

        if lower_line.find(new.lower()):
            set_options.add(new.lower())
            continue

    if not was_replaced:
         new_lines.append(line)

print("Setting up SSH options...")
for (old, new) in replaced_options:
    print(f"Replaced \"{old}\" with \"{new}\"")

added_options = 0
for (old, new) in options:
    if new.lower() in set_options:
        continue

    new_lines.append(new + "\n")
    print(f"Added \"{new}\"")
    added_options += 1


print(f"SSH was set up: {len(replaced_options) + added_options} options were modified or added.")

with open(file_path, "w") as config_file:
    config_file.seek(0)
    config_file.writelines(new_lines)
    config_file.truncate()
