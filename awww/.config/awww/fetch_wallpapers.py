#!/usr/bin/env python3
"""
Fetch wallpapers from URLs in wallpapers.json.
Extracts image source from <img id="wallpaper"> tag.

Usage:
    python fetch_wallpapers.py [--dry-run] [--update] [--force] [--output-dir DIR]

Options:
    --dry-run    Show what would be downloaded without downloading
    --update     Only download missing files
    --force      Re-download all files
    --output-dir DIR  Specify output directory (default: ~/.local/share/awww/wallpapers)
"""

import argparse
import json
import time
import os
import sys
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin, urlparse
import hashlib

CONFIG_DIR = os.path.expanduser("~/.config/awww")
DEFAULT_WALLPAPER_DIR = os.path.expanduser("~/.local/share/awww/wallpapers")
WALLPAPERS_JSON = os.path.join(CONFIG_DIR, "wallpapers.json")

# Requests session with custom headers
SESSION = requests.Session()
SESSION.headers.update({
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) awww-fetcher/1.0"
})


def load_wallpapers():
    """Load wallpaper URLs from JSON file.
    
    Supports multiple formats:
    - Simple list: ["url1", "url2", ...]
    - Object with urls key: {"urls": ["url1", "url2", ...]}
    - Object with wallpapers key: {"wallpapers": ["url1", "url2", ...]}
    """
    with open(WALLPAPERS_JSON, "r") as f:
        data = json.load(f)
        # Handle different formats
        if isinstance(data, list):
            return data
        elif isinstance(data, dict):
            if "urls" in data:
                return data["urls"]
            elif "wallpapers" in data:
                return data["wallpapers"]
            else:
                raise ValueError("Invalid wallpapers.json format. Expected a list of URLs or object with 'urls' or 'wallpapers' key.")
        else:
            raise ValueError("Invalid wallpapers.json format. Expected a list of URLs or object with 'urls' or 'wallpapers' key.")


def get_image_url(page_url):
    """Extract image URL from <img id="wallpaper"> tag."""
    try:
        response = SESSION.get(page_url, timeout=10)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, "html.parser")
        img_tag = soup.find("img", {"id": "wallpaper"})
        if img_tag and img_tag.get("src"):
            return urljoin(page_url, img_tag["src"])
        return None
    except Exception as e:
        print(f"Error fetching {page_url}: {e}")
        return None


def sanitize_filename(url):
    """Create a safe filename from URL."""
    # Use hash of URL for consistent naming
    url_hash = hashlib.sha256(url.encode()).hexdigest()[:16]
    
    # Try to get extension from URL
    parsed = urlparse(url)
    path = parsed.path
    ext = os.path.splitext(path)[1] or ".jpg"
    
    return f"{url_hash}{ext}"


def download_wallpaper(image_url, page_url, force):
    """Download a single wallpaper image."""
    os.makedirs(WALLPAPER_DIR, exist_ok=True)
    
    filename = sanitize_filename(image_url)
    filepath = os.path.join(WALLPAPER_DIR, filename)
    
    # Check if already exists (unless force mode)
    if not force and os.path.exists(filepath):
        print(f"Already exists: {filename}")
        return filepath
    
    try:
        # Add referer header to help with some image hosts
        headers = {"Referer": page_url}
        response = SESSION.get(image_url, timeout=30, stream=True, headers=headers)
        response.raise_for_status()
        
        with open(filepath, "wb") as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)
        
        print(f"Downloaded: {filename}")
        return filepath
    except Exception as e:
        print(f"Error downloading {image_url}: {e}")
        return None


def main():
    parser = argparse.ArgumentParser(
        description="Fetch wallpapers from wallpapers.json"
    )
    parser.add_argument("--dry-run", action="store_true", 
                        help="Show what would be downloaded")
    parser.add_argument("--update", action="store_true", 
                        help="Only download missing files")
    parser.add_argument("--force", action="store_true", 
                        help="Re-download all files")
    parser.add_argument("--output-dir", default=DEFAULT_WALLPAPER_DIR, 
                        help="Output directory (default: ~/.local/share/awww/wallpapers)")
    args = parser.parse_args()
    
    global WALLPAPER_DIR
    WALLPAPER_DIR = args.output_dir
    
    # Load wallpapers
    wallpapers = load_wallpapers()
    
    if not wallpapers:
        print("No wallpapers found in wallpapers.json")
        return
    
    print(f"Found {len(wallpapers)} wallpaper URLs")
    print(f"Output directory: {WALLPAPER_DIR}")
    
    for page_url in wallpapers:
        # Extract filename for display (from URL)
        display_name = os.path.basename(urlparse(page_url).path) or page_url
        
        print(f"\nProcessing: {display_name}")
        print(f"  Source: {page_url}")
        
        image_url = get_image_url(page_url)
        if not image_url:
            print(f"  ERROR: Could not find <img id=\"wallpaper\"> at {page_url}")
            continue
        
        print(f"  Image: {image_url}")
        
        if args.dry_run:
            continue
        
        if args.update and os.path.exists(
            os.path.join(WALLPAPER_DIR, sanitize_filename(image_url))
        ):
            print(f"  Skipping (already exists)")
            continue
        # sleep 1 second to not spam the website too much, otherwise we can get blocked 
        time.sleep(1)
        download_wallpaper(image_url, page_url, args.force)


if __name__ == "__main__":
    main()
