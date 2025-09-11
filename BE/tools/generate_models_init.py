import re
from pathlib import Path

MODELS_DIR = Path("app/models")
INIT_FILE = MODELS_DIR / "__init__.py"


def extract_tbl_classes(file_path: Path):
    content = file_path.read_text()
    return re.findall(r"^class\s+(Tbl\w+)\b", content, re.MULTILINE)


def main():
    lines = []
    all_exports = []

    for file in sorted(MODELS_DIR.glob("*_model.py")):
        classes = extract_tbl_classes(file)
        if not classes:
            continue
        import_path = f".{file.stem}"
        class_list = ", ".join(classes)
        lines.append(f"from {import_path} import {class_list}")
        all_exports.extend(classes)

    lines.append("")  # newline before __all__
    lines.append("__all__ = [")
    for cls in all_exports:
        lines.append(f'    "{cls}",')
    lines.append("]")

    INIT_FILE.write_text("\n".join(lines))
    print(f"✅ Updated {INIT_FILE}")


if __name__ == "__main__":
    main()
