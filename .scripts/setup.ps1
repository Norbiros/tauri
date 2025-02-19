#!/usr/bin/env pwsh

# Copyright 2019-2024 Tauri Programme within The Commons Conservancy
# SPDX-License-Identifier: Apache-2.0
# SPDX-License-Identifier: MIT

echo "Building API definitions..."
cd tooling\api
pnpm i; pnpm build
cd ..\..

echo "Installing the Tauri Rust CLI..."
cd tooling\cli
cargo install --path .
cd ..\..
echo "Tauri Rust CLI installed. Run it with '$ cargo tauri [COMMAND]'."

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes"
$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No"
$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

$result = $host.ui.PromptForChoice("Node.js CLI", "Do you want to install the Node.js CLI?", $options, 1)
switch ($result) {
  0{
    cd tooling\cli\node
    pnpm i; pnpm build; pnpm link
    cd ..\..
    echo "Tauri Node.js CLI installed. use `pnpm link @tauri-apps/cli` and run it with '$ pnpm tauri [COMMAND]'."
  }
}
