/**
 * Automatically open external links in new windows
 * Internal links stay in the same window
 */
document.addEventListener('DOMContentLoaded', function() {
    // Get the current domain
    const currentDomain = window.location.hostname;
    
    // Find all links on the page
    const links = document.querySelectorAll('a[href]');
    
    links.forEach(function(link) {
        const href = link.getAttribute('href');
        
        // Skip if it's not a valid URL or is already set to open in new window
        if (!href || href.startsWith('#') || href.startsWith('mailto:') || href.startsWith('tel:')) {
            return;
        }
        
        // Check if it's an external link
        try {
            // Handle relative URLs (internal links)
            if (href.startsWith('/') || href.startsWith('./') || href.startsWith('../')) {
                // This is an internal link, do nothing
                return;
            }
            
            // Handle absolute URLs
            if (href.startsWith('http://') || href.startsWith('https://')) {
                const linkDomain = new URL(href).hostname;
                
                // If it's external, open in new window
                if (linkDomain !== currentDomain) {
                    link.setAttribute('target', '_blank');
                    link.setAttribute('rel', 'noopener noreferrer');
                }
            }
        } catch (e) {
            // If URL parsing fails, treat as internal link
            console.log('Could not parse URL:', href);
        }
    });
});