using System;

namespace TimeTableManager.ServiceManager.Caching
{
    /// <summary>
    /// The CacheService interface.
    /// </summary>
    public interface ICacheService
    {
        /// <summary>
        /// Retrieves the cached item from Memory cache, if the item is not already cashed, it will call the delegate and cashe the result.
        /// </summary>
        /// <typeparam name="T">Type of cached item.</typeparam>
        /// <param name="cacheKey">Key of cached item.</param>
        /// <param name="getItemFromSourceCallback">A call back delegate if item is not already in the cache.</param>
        /// <returns>Cached item.</returns>
        T GetOrSet<T>(string cacheKey, Func<T> getItemFromSourceCallback) where T : class;
    }
}