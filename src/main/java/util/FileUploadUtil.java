package util;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * FileUploadUtil — handles image file uploads for products and user avatars.
 * Files are saved to: webapp/assets/images/uploads/
 */
public class FileUploadUtil {

    // Allowed image types
    private static final String[] ALLOWED_TYPES = {"image/jpeg", "image/png", "image/jpg", "image/webp"};
    private static final long MAX_SIZE_BYTES    = 2 * 1024 * 1024; // 2 MB

    /**
     * Save an uploaded file part to the given folder.
     *
     * @param part         The uploaded file Part from multipart request
     * @param uploadFolder Absolute path to the folder where file will be saved
     * @return             New unique filename (e.g. "abc123.jpg"), or null if no file
     * @throws IOException If file save fails
     * @throws IllegalArgumentException If file type or size is invalid
     */
    public static String saveFile(Part part, String uploadFolder) throws IOException {
        if (part == null || part.getSize() == 0) return null;

        // Validate content type
        String contentType = part.getContentType();
        boolean allowed = false;
        for (String type : ALLOWED_TYPES) {
            if (type.equalsIgnoreCase(contentType)) { allowed = true; break; }
        }
        if (!allowed) throw new IllegalArgumentException("Only JPG, PNG, WEBP images are allowed.");

        // Validate file size
        if (part.getSize() > MAX_SIZE_BYTES) {
            throw new IllegalArgumentException("File size must be less than 2MB.");
        }

        // Get original file extension
        String originalName = part.getSubmittedFileName();
        String extension    = originalName.substring(originalName.lastIndexOf('.'));

        // Generate unique filename to avoid collisions
        String newFileName = UUID.randomUUID().toString() + extension;

        // Create folder if it doesn't exist
        File folder = new File(uploadFolder);
        if (!folder.exists()) folder.mkdirs();

        // Save the file
        part.write(uploadFolder + File.separator + newFileName);

        return newFileName;
    }
}