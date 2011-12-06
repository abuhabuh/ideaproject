class TagsController < ApplicationController

  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  def add_tags_to_idea

=begin - THIS IS CODE (some of it at the bottom) FOR FINDING SIMILAR IDEAS 
    puts "tag_list count: " + idea.tag_list.count.to_s
    puts "tag_count count: " + idea.tag_counts.count.to_s
    puts "tag list: "
    idea.tag_list.each do |tag| 
      puts "  " + tag.name
    end

    ideas = Idea.tagged_with("Journey").group("ideas.id")#.paginate(:page => 1, :per_page => 10)
    ideas.each do |single_idea|
      puts "idea text: " + single_idea.text
    end

    ideas.sort_by! {|idea_item| -(idea_item.tag_counts.where("name = ?", "Journey").first.count)}
    puts "sorted"
    ideas.each do |single_idea|
      puts "idea text: " + single_idea.text
    end

    current_user_tags = idea.tags_from(current_user)
    puts "current user tags"
    current_user_tags.each do |tag|
      puts " " + tag
    end
=end

    idea = Idea.find(params[:idea_id])

    # TODO: We have to get existing tags from DB and then append new tag. There should be a method to add a new tag
    #       from a specific user to the object but I didn't find it.
    old_tag_list = idea.tags_from(current_user)
    new_tag_list = idea.tags_from(current_user).join(", ") + ", " + params[:tag_list]
    current_user.tag(idea, :with => new_tag_list, :on => :tags)

    tag_list_array = idea.tags_from(current_user)

    respond_to do |format|
      format.js {
        render :partial => 'tags/update_tags_to_idea', 
               :locals => {:current_tag_list => tag_list_array, :idea_id => params[:idea_id]}
      }
    end
  end


  def remove_tag_from_idea
    idea = Idea.find(params[:idea_id])

    user_tag_list = idea.tags_from(current_user)
    user_tag_list.remove(params[:tag_string])

    current_user.tag(idea, :with => user_tag_list.join(", "), :on => :tags)

    respond_to do |format|
      format.js {
        render :partial => 'tags/update_tags_to_idea',
               :locals => {:current_tag_list => user_tag_list, :idea_id => params[:idea_id]}
      }
    end
  end


  # Unimplemented
  def add_tags_to_user


  end

end