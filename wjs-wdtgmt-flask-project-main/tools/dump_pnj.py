import requests, re, json, argparse, os, threading

def get_info(web_page):
    # get the html page
    page = requests.get(web_page)

    # find title and price
    regex = re.compile(r'ty-product-block-title".*?<|ty-price-num".*?<|product_code_w.*?<')
    match = regex.findall(page.text)[0:3]

    # find image
    regex = re.compile(r'(https://cdn.pnj.io/images/detailed/.*?png)')
    match += regex.findall(page.text)[0:1]


    #find sub info
    regex = re.compile(r'(ty-product-feature__.*?<)')
    matches = regex.findall(page.text)
    matches = [match.split(">")[1].replace('<', '').replace(':', '') for match in matches if len(match.split("suffix")) < 2]
    matches = {matches[i]: matches[i+1] for i in range(0, len(matches), 2)}

    return {
        "title": match[0].split(">")[1].replace('<', ''),
        "price": int(match[2].split(">")[1].replace('<', '').replace('.', '')),
        "code": match[1].split(">")[1].replace('<', ''),
        "image": match[3],
        "info": matches
    }

def worker(item):
    data = get_info(item)
    if len(data["code"]) != 13:
        print("Skiped " + item + " (Invalid code)")
        return
    with open("./data/"+ data["code"]+".json", "w", encoding="utf-8") as file:
        json.dump(data, file, indent=4, ensure_ascii=False)
    print("Dumped " + item + "!")

def get_categories(web_page):
    # get the html page
    page = requests.get(web_page)

    # find title and price
    regex = re.compile(r'https://www.pnj.com.vn/[a-z0-9-.]+html')
    match = regex.findall(page.text)
    #remove duplicate and links that are not products (contain at least 1 number)
    match = list(set(match))
    match = [link for link in match if re.search(r'[0-9]', link)]
    # try to make data folder
    try:
        os.mkdir("./data")
    except:
        pass
    print("Found " + str(len(match)) + " products!")
    for item in match:
        threading.Thread(target=worker, args=(item,)).start()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Dump infos of an PNJ category to file')
    parser.add_argument('website', metavar='website', type=str, help='website to dump')
    args = parser.parse_args()
    get_categories(args.website)