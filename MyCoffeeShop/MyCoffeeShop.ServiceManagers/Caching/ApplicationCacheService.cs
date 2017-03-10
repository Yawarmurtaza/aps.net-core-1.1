using System;

using Microsoft.Extensions.Caching.Memory;

namespace TimeTableManager.ServiceManager.Caching
{
    /// <summary>
    /// The letting cache service.
    /// </summary>
    public class ApplicationCacheService : ICacheService
    {
        private readonly IMemoryCache cache;
        public ApplicationCacheService(IMemoryCache cache)
        {
            this.cache = new MemoryCache(new MemoryCacheOptions());
        }

        /// <summary> Retrieves the cached item from Memory cache, if the item is not already cashed, it will call the delegate and cashe the result. </summary>
        /// <typeparam name="T">Type of cached item.</typeparam>
        /// <param name="cacheKey">Key of cached item.</param>
        /// <param name="getItemFromSourceCallback">A call back delegate if item is not already in the cache.</param>
        /// <returns>Cached item.</returns>
        public T GetOrSet<T>(string cacheKey, Func<T> getItemFromSourceCallback) where T : class
        {
            // try to retreive the cach item from the memory...
            T item = this.cache.Get(cacheKey) as T;

            if (item == null)
            {
                // if the item is not available in the memory, then call the delegate.
                item = getItemFromSourceCallback();

                // and store the result back into this memory with the same item key value.
                this.cache.Set(cacheKey, item, DateTime.Now.AddMinutes(15)); // time from appSettings.
            }

            return item;
        }
    }
}