import os
import re
from pathlib import Path

MODEL_DIR = Path("app/models")
SCHEMA_DIR = Path("app/schemas")
BASE_SCHEMAS = {
    "Create": [],
    "Read": ["UpdatedSchema", "CreatedSchema", "IdSchema"],
    "Update": [],
}


def to_snake_case(name):
    return re.sub(r"(?<!^)(?=[A-Z])", "_", name).lower()


def extract_base_class_name(file_content):
    match = re.search(r"class\s+(\w+Base)\s*\(.*\):", file_content)
    return match.group(1) if match else None


def extract_model_import(file_path):
    relative = file_path.relative_to(MODEL_DIR.parent)
    return str(relative).replace(os.sep, ".").replace(".py", "")


def generate_schema_code(model_file: Path):
    content = model_file.read_text()
    base_class = extract_base_class_name(content)

    if not base_class:
        print(f"⚠️  Skipped {model_file.name} (no base class found)")
        return

    class_prefix = base_class.replace("Base", "")
    import_path = extract_model_import(model_file)

    schema_lines = [
        f"from {import_path} import {base_class}",
        "from .base_schema import IdSchema, CreatedSchema, UpdatedSchema",
        "",
    ]

    for variant, mixins in BASE_SCHEMAS.items():
        class_name = f"{class_prefix}{variant}"
        base_classes = ", ".join(mixins + [base_class])
        schema_lines.append(f"class {class_name}({base_classes}):")
        schema_lines.append("    pass\n")

    schema_file = SCHEMA_DIR / f"{to_snake_case(class_prefix)}_schema.py"
    schema_file.write_text("\n".join(schema_lines))
    print(f"✅ Generated {schema_file.name}")


def main():
    SCHEMA_DIR.mkdir(parents=True, exist_ok=True)

    for model_file in MODEL_DIR.glob("*_model.py"):
        generate_schema_code(model_file)


if __name__ == "__main__":
    main()
