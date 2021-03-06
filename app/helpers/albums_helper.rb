module AlbumsHelper
  def can_edit_album?(album)
    signed_in? && current_user == album.user
  end
  
  def album_thumbnail(album)
    if album.pictures.count > 0
      image_tag(album.pictures.first.asset.url(:thumb))
    else
      image_tag("http://blog.buzzintown.com/wp-content/uploads/2012/09/Durga-Puja-Photo-e1348825601510.jpg")
    end
  end
end
