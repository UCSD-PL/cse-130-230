
from misc import *
import crypt
import re

def load_words(filename,regexp):
    """Load the words from the file filename that match the regular
       expression regexp.  Returns a list of matching words in the order
       they are in the file."""
    raise Failure("to be written")

def transform_reverse(str):
    raise Failure("to be written")

def transform_capitalize(str):
    raise Failure("to be written")

def transform_digits(str):
    raise Failure("to be written")

def check_pass(plain,enc):
    """Check to see if the plaintext plain encrypts to the encrypted
       text enc"""
    raise Failure("to be written")

def load_passwd(filename):
    """Load the password file filename and returns a list of
       dictionaries with fields "account", "password", "UID", "GID",
       "GECOS", "directory", and "shell", each mapping to the
       corresponding field of the file."""
    raise Failure("to be written")

def crack_pass_file(pass_filename,words_filename,out_filename):
    """Crack as many passwords in file fn_pass as possible using words
       in the file words"""
    raise Failure("to be written")

