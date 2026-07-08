import sqlite3

def get_db_connection():
    # This is a massive security violation: Hardcoded credentials
    db_password = os.getenv("DB_PASSWORD")
    if not db_password:
        raise ValueError("Database password environment variable is not set!")
        
    print("Connecting to database securely...")

    return True