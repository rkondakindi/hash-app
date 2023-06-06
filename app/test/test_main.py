from src.api_functions import get_hash_data_from_s3
from src.api_functions import post_hash_data_to_s3
import pytest
import hashlib

def test_post_call():
    hash_key = post_hash_data_to_s3('first', 'last', 'dateofbirth')

    message = 'first'+'last'+'dateofbirth'
    assert hashlib.sha256(message.encode()).hexdigest() == hash_key

    # Test case 2: Hashing two different strings should produce different hash values
    hash_key2 = post_hash_data_to_s3('firstName', 'lastName', 'dateofbirth')
    assert hash_key != hash_key2
    
    # Test case 3: Hashing a long string should produce a hash value of the correct length
    long_name_hash = post_hash_data_to_s3('firstName is big name to get hash','lastNameis also big name to get hash','dateofbirth')
    assert len(long_name_hash) == 64

def test_get_call():
    message = 'first11'+'last'+'dateofbirth'
    hash_key =  hashlib.sha256(message.encode()).hexdigest()
    assert get_hash_data_from_s3(hash_key) == "Matching Hash key Not Found"

    hash_key2 = post_hash_data_to_s3('first','last','dateofbirth')
    assert get_hash_data_from_s3(hash_key2) == ['first', 'last', 'dateofbirth']

    hash_key3 = post_hash_data_to_s3('','','')
    assert get_hash_data_from_s3(hash_key3) == ['', '', '']
    
    


