from pathlib import Path

project_structure = [
    "lib/core/constants/app_colors.dart",
    "lib/core/constants/app_sizes.dart",
    "lib/core/constants/ble_constants.dart",

    "lib/core/theme/app_theme.dart",

    "lib/models/expression_model.dart",
    "lib/models/news_item.dart",
    "lib/models/announcement_item.dart",

    "lib/providers/robot_provider.dart",

    "lib/services/bluetooth_service.dart",

    "lib/screens/main_shell.dart",

    "lib/screens/dashboard/dashboard_screen.dart",

    "lib/screens/expressions/expressions_screen.dart",

    "lib/screens/news/news_screen.dart",

    "lib/screens/announcements/announcements_screen.dart",

    "lib/screens/iot/iot_screen.dart",

    "lib/screens/settings/settings_screen.dart",

    "lib/widgets/tara_bottom_dock.dart",
    "lib/widgets/glass_card.dart",
    "lib/widgets/status_pill.dart",
    "lib/widgets/section_header.dart",
    "lib/widgets/robot_hero.dart",
    "lib/widgets/floating_action_chip.dart",

    "lib/utils/ble_permissions.dart",

    "lib/main.dart",
]

# Create folders and files
for file_path in project_structure:
    path = Path(file_path)

    # Create parent directories
    path.parent.mkdir(parents=True, exist_ok=True)

    # Create file if not exists
    if not path.exists():
        path.touch()
        print(f"Created: {path}")
    else:
        print(f"Already exists: {path}")

print("\n✅ TARA AI Receptionist project structure created successfully!")