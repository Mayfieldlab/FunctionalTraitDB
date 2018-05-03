import pandas as pd
import requests
from bs4 import BeautifulSoup
import re


def get_genus_family(soup, id_name):
    """Function to scrape all genus and family names from website, 
    turn into dataframe"""
    genus_list = []
    family_list = []

    for plant in soup.find_all(id=id_name):
        for genus in plant.find_all(class_=re.compile("genus")):
            name = genus.get_text()
            genus_list.append(name)
        for family in plant.find_all(class_="family"):
            name2 = family.get_text()
            family_list.append(name2)

    # join family_list and genus_list into a dataframe.
    result = pd.concat([pd.DataFrame(genus_list, columns=['genus']),
                        pd.DataFrame(family_list, columns=['family'])], axis=1)
    return result


def main():
    """Function to get data from URL, 
    Run get_genus_family function and export it as a csv."""
    DATA_URL = 'http://www.theplantlist.org/1.1/browse/-/-/'

    r = requests.get(DATA_URL)
    soup = BeautifulSoup(r.text, 'html.parser')  # get text from data.URL

    # Export as csv
    pd.DataFrame(get_genus_family(soup, "nametree")).to_csv('genus_family.csv', header=True)


if __name__ == '__main__':
    main()
