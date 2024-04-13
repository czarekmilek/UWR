import aiohttp
import asyncio
import json
from private import FAVQS_API_KEY  # FavQs key

async def fetch_data_without_auth(url):
    try:
        async with aiohttp.ClientSession() as session:
            async with session.get(url) as response:
                return await response.text()
    except Exception as e:
        print(f"Error fetching data from {url}: {e}")
        return None
    

async def fetch_data_with_auth(url, headers):
    try:
        async with aiohttp.ClientSession() as session:
            async with session.get(url, headers=headers) as response:
                return await response.text()
    except Exception as e:
        print(f"Error fetching data from {url}: {e}")
        return None
    
##########################################

async def main():
    # FavQs API (requires API key)
    favqs_api_url = "https://favqs.com/api/quotes/"

    # MeowFacts API (bez uwierzytelnienia)
    meowfacts_url = "https://meowfacts.herokuapp.com/"

    favqs_api_headers = {
        "Authorization": f"Token token={FAVQS_API_KEY}",
        "Accept": "application/json",
    }

    tasks = [
        fetch_data_with_auth(favqs_api_url, headers=favqs_api_headers),
        fetch_data_without_auth(meowfacts_url),
    ]

    results = await asyncio.gather(*tasks)

    # debugging
    # print("Raw response from FavQs API:", results[0])
    # print("Raw response from MeowFacts API:", results[1])

    print("=======================================")
    print("=======================================")
    print("Dane z FavQsAPI:")
    try:
        favqs_data = json.loads(results[0])
        for i in favqs_data["quotes"]:
            print(i["body"] + " ~ " + i["author"])
    except json.JSONDecodeError:
        print("Warning: Invalid API Key for FavQs API. No output.")
    
    print("=======================================")
    try:
        meowfacts_data = json.loads(results[1]) if results[1] else None
        print("Dane z MeowFacts API:\n", meowfacts_data['data'])
    except json.JSONDecodeError:
        print("Error decoding JSON from MeowFacts API")
    except KeyError:
        print("Invalid response format from MeowFacts API")

    print("=======================================")


if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())

# if __name__ == "__main__":
#     asyncio.run(main())
