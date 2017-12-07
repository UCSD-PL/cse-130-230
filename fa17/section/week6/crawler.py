import urllib2
import re
import sys
import time;
from time import sleep

# Starting with our code to fetch a page from the basic.py...
def getWebContent(url) :
    response = urllib2.urlopen(url)
    html = response.read()
    response.close()
    return html

# Lets write a web crawler! A web crawler is a program that downloads a web page, finds all links inside it
# and recursively visits all links

# So first how do we find links? Why not regular expressions! As a first try,
# a link is anything that starts with http (maybe s), and is followed by a sequence of letters, dots, slashes etc..
# Try this regular expression on a couple of pages:
r = re.compile(r"http[s]?://[a-zA-Z\.-]+")

# However this is a little limited. For example in a document links can be just "page.html", or "/foo/bar/page.html". The https:// is not neccessary
# Another way to find links is, to look for html anchors - i.e. anything that looks like <a href="some link">. This leads to our second try,
# that just looks for "<a ... href="something">" and extracts the "somthing" by puting it into a regular expression group (the parenthesis after the href pattern.
r1 = re.compile(r"<a[^>]*href=[\"']([^\"']*)[\"']")

# With our new regular expression extracting links is trivial! Just fall r1.findall(text of the page).
def extractAllLinks(html) :
    # Now a lot of these will be just of the shape "/foo/bar/page.html". Thats not a full address,so you can't download it.
    # So we pre-pend the domain (i.e. the webserver name) to these addresses, if we detect that the links begin with "/"
    links1= map(lambda x: domain+x, filter(lambda x:  x[0]=='/', r1.findall(html)))

    # Homework: The above map is still not sufficient. What about links like <a href="page.html">? They don't begin with /. And they don't
    # include the full server name. Can you fix this function to also correctly handle those?
    links2= r.findall(html)
    return links1 + links2

# Next lets add command line arguments to our script - the first argument is the starting address (e.g. cseweb.ucsd.edu/index.html) and the second argument is the
# domain we will be crawling (cseweb.ucsd.edu)
start = sys.argv[1]
domain = sys.argv[2]

# Any good crawler has a queue of websites that we need to visit..
q = [start]

# And lets also remember what sites we visited. We don't want to visit them more than once. For this we can just use a dictionary d
# Homework: Can you think of a more appropriate python type to use here?
d = {}


# Finally we are ready to crawl!
while (len(q) > 0):
  cur_page = q.pop(0)

  # If this links leads outside of the domain we are trying to crawl, skip it.
  if (not cur_page.startswith(domain)):
    continue
    
  # If the current page has already been visited, skip it.
  if (cur_page in d):
    pass
  else:
    d[cur_page] = 1;
    print cur_page
    # Our 'link extraction' code is not perfect. Sometimes it will extract something that is not really a link.
    # Also our internet may be unreliable, wifi can disconnect. But we don't want our crawler to crash just because of that!
    # So lets use a try/except block. We will _try_ to get the webpage, and extract all links. If we fail to downlaod the page, we will get an
    # urllib2.HTTPError exception, and we can just make a note that we couldnt' get this page and drive on...
    # Note that in our except block we are _only_ catching urllib2.HTTPErrors! We don't want to mask out other errors.
    try:
      body = getWebContent(cur_page);
      links = extractAllLinks(body)
      q.extend(links)
    except urllib2.HTTPError:
      print "Can't find ", cur_page
      
# And there you have it: A small functional web crawler.

# Homework: Try and extend this code with options to throttle the crawling - we don't want to annoy web admins
# Homework: Try and extend this code with the option to crawl multiple domains, not just one.
