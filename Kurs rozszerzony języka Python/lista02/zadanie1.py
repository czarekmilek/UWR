def honda(votes, seats):
    results = [0] * len(votes)
    
    total_votes = sum(votes)
    # Próg wyborczy to 5%
    prog = 0.05 * total_votes
    
    for seat in range(seats):
        max_ilo = 0
        win_party = -1
        
        for i in range(len(votes)):
            # Czy komitet przekroczył próg
            if votes[i] >= prog:
                iloraz = votes[i] / (results[i] + 1)
                if iloraz > max_ilo:
                    max_ilo = iloraz
                    win_party = i
        
        results[win_party] += 1
    
    return results

# test
votes = [100000, 111000, 88000, 45000, 66000, 30000]
seats = 21

results = honda(votes, seats)
print("Wyniki wyborów:")
#print(results)
for i in range(len(results)):
    print(f"Komitet {i + 1}: {results[i]} miejsc")
