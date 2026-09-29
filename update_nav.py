import os
import re

html_files = [f for f in os.listdir('.') if f.endswith('.html')]

new_ul = """<ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="index.html">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="home-2.html">Home 2</a></li>
                    <li class="nav-item"><a class="nav-link" href="book-now.html">Book Now</a></li>
                    <li class="nav-item"><a class="nav-link" href="services.html">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="gallery.html">Gallery</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.html">About</a></li>
                </ul>"""

for filename in html_files:
    with open(filename, 'r', encoding='utf-8') as f:
        content = f.read()

    # Replace the ul block
    content = re.sub(r'<ul class="navbar-nav ms-auto">.*?</ul>', new_ul, content, flags=re.DOTALL)

    # Set active class
    search_str = f'class="nav-link" href="{filename}"'
    replace_str = f'class="nav-link active" href="{filename}"'
    content = content.replace(search_str, replace_str)

    with open(filename, 'w', encoding='utf-8') as f:
        f.write(content)
        
print("Nav updated.")
